#!/bin/sh

configure_divi() {
  if [ x"${DIVI_CONF}" != "x" ]; then
    echo $(date -Is) Setting default divi.conf to ${DIVI_CONF}
  else
    DIVI_CONF=/etc/divi/divi.conf
  fi

  if [ ! -d "$(dirname "$DIVI_CONF")" ]; then
    mkdir -p "$(dirname "$DIVI_CONF")"
  fi

  if [ x"${DIVI_DATADIR}" != "x" ]; then
    echo $(date -Is) Setting default data dir to ${DIVI_DATADIR}
  else
    DIVI_DATADIR=/var/lib/divid
  fi

  if [ ! -d "${DIVI_DATADIR}" ]; then
    mkdir -p "${DIVI_DATADIR}"
  fi

  # Create the divi.conf file if it doesn't exist
  if [ ! -f ${DIVI_CONF} ]; then
    echo $(date -Is ) STARTING CONFIGURATION

    DIVI_RANDOM_PASSWORD=$(openssl rand -base64 32)
    echo $(date -Is) GOT DIVI_RANDOM_PASSWORD ${DIVI_RANDOM_PASSWORD}
    if [ x"${DIVI_RPCUSER}" != "x" ]; then
      echo rpcuser=${DIVI_RPCUSER} >> ${DIVI_CONF}
    else
      echo rpcuser=divirpc >> ${DIVI_CONF}
    fi

    if [ x"${DIVI_RPCPASSWORD}" != "x" ]; then
      echo rpcpassword=${DIVI_RPCPASSWORD} >> ${DIVI_CONF}
    else
      echo $(date -Is) Writing random rpcpassword ${DIVI_RANDOM_PASSWORD} to divi.conf
      echo rpcpassword=${DIVI_RANDOM_PASSWORD} >> ${DIVI_CONF}
    fi

    if [ x"${DIVI_OPENRPC}" != "x" ]; then
      echo rpcallowip=0.0.0.0/0 >> ${DIVI_CONF}
    fi

    if [ x"${DIVI_TESTNET}" != "x" ]; then
      echo testnet=1 >> ${DIVI_CONF}
    fi
    
    if [ x"${DIVI_REGTEST}" != "x" ]; then
      echo regtest=1 >> ${DIVI_CONF}
    fi

    if [ x"${DIVI_RPCPORT}" != "x" ]; then
      echo rpcport=${DIVI_RPCPORT} >> ${DIVI_CONF}
    fi

    if [ x"${DIVI_PORT}" != "x" ]; then
      echo port=${DIVI_PORT} >> ${DIVI_CONF}
    fi

    # Connect via a SOCKS5 proxy
    if [ x"${DIVI_PROXY}" != "x" ]; then
      echo proxy=${DIVI_PROXY} >> ${DIVI_CONF}
    fi

    # Handle multiple addnode entries
    env | grep '^DIVI_ADDNODE' | while IFS='=' read -r key value; do
        if [ -n "$value" ]; then
            echo "addnode=$value" >> ${DIVI_CONF}
        fi
    done

    # Handle multiple connect entries
    env | grep '^DIVI_CONNECT' | while IFS='=' read -r key value; do
        if [ -n "$value" ]; then
            echo "connect=$value" >> ${DIVI_CONF}
        fi
    done

    # Handle multiple connect entries
    env | grep '^DIVI_RPCALLOWIP' | while IFS='=' read -r key value; do
        if [ -n "$value" ]; then
            echo "rpcallowip=$value" >> ${DIVI_CONF}
        fi
    done

    # Set the maximum number of connections
    if [ x"${DIVI_MAXCONNECTIONS}" != "x" ]; then
      echo maxconnections=${DIVI_MAXCONNECTIONS} >> ${DIVI_CONF}
    fi

    echo $(date -Is) SETTING DATA DIRECTORY
    echo datadir=${DIVI_DATADIR} >> ${DIVI_CONF}

    echo DIVI_CONF=${DIVI_CONF} >> ~/.profile
    echo DIVI_DATADIR=${DIVI_DATADIR} >> ~/.profile

    echo $(date -Is) FINISHED CONFIGURATION
    echo $(date -Is) DIVI CONFIGURATION
    cat ${DIVI_CONF}
  fi
}

handle_snapshot() {
  if [ x"${DIVI_TESTNET}" != "x" ] && [ x"${DIVI_SNAPSHOT}" != "x" ]; then
    echo "Divi Testnet does not have an active snapshot, skipping"
    return
  fi

  if [ x"${DIVI_SNAPSHOT_URL}" == "x" ]; then
    DIVI_SNAPSHOT_URL=https://snapshots.diviproject.org/dist/DIVI-snapshot.tar.gz
  fi

  if [ x"${DIVI_SNAPSHOT_FILENAME}" == "x" ]; then
    DIVI_SNAPSHOT_FILENAME=DIVI-snapshot.tar.gz
  fi

  if [ x"${DIVI_SNAPSHOT}" != "x" ]; then
    echo $(date -Is) STARTING SNAPSHOT
    cd ${DIVI_DATADIR}
    ls | grep -v divi.conf | grep -v backups | grep -v monthlyBackups | grep -v masternode.conf | grep -v wallet.dat | grep -v debug.log | xargs rm -rf
    if [ -e "$DIVI_SNAPSHOT_FILENAME" ]; then 
      echo $(date -Is) "Found File: $DIVI_SNAPSHOT_FILENAME"
      rm DIVI-snapshot.tar.gz
    fi
  echo $(date -Is) DOWNLOADING SNAPSHOT
    wget --quiet $DIVI_SNAPSHOT_URL
    stat $DIVI_SNAPSHOT_FILENAME
    ls -ahl $DIVI_SNAPSHOT_FILENAME
    chmod 7777 $DIVI_SNAPSHOT_FILENAME
    echo $(date -Is) DECOMPRESSING SNAPSHOT
    tar xfz $DIVI_SNAPSHOT_FILENAME
    rm $DIVI_SNAPSHOT_FILENAME
    echo $(date -Is) FINISHED SNAPSHOT
  fi
}


configure_divi
handle_snapshot

echo $(date -Is) STARTING DIVID
# /usr/bin/divid -conf=${DIVI_CONF} -datadir=${DIVI_DATADIR} # --daemon
/usr/bin/supervisord -c /etc/supervisord.conf &


start_time=$(date +%s)
timeout=300  # 5 minutes in seconds

if [ x"${DIVI_DEBUG_TIMEOUT}" != "x" ]; then
  timeout=${DIVI_DEBUG_TIMEOUT}
  echo $(date -Is) "Setting DIVI_DEBUG_TIMEOUT to ${timeout} seconds"
fi

if [ x"${DIVI_REGTEST}" != "x" ]; then
  DIVI_DEBUG_FILE="${DIVI_DATADIR}/regtest/debug.log"
else
  DIVI_DEBUG_FILE="${DIVI_DATADIR}/debug.log"
fi

while [ ! -f "${DIVI_DEBUG_FILE}" ]; do
    current_time=$(date +%s)
    elapsed_time=$((current_time - start_time))
    
    if [ $elapsed_time -ge $timeout ]; then
        echo "Timeout: ${DIVI_DEBUG_FILE} did not appear after ${timeout} seconds. Exiting."
        exit 1
    fi
    
    sleep 1
done

echo $(date -Is) "DIVI_DEBUG_FILE ${DIVI_DEBUG_FILE} exists. Following the log file."
tail -f ${DIVI_DEBUG_FILE}