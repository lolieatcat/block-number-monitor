#!/bin/bash
set -x

echo "Mainnet blockNumber monitor start"
blockNumber="N/A"
oldBlockNumber="N/A"
err=0
while true 
do
blockNumber=$(curl -X POST --data '{"method":"eth_blockNumber","params":[],"id":"1","jsonrpc":"2.0"}' http://localhost:6666/)
echo $blockNumber

if [ "$blockNumber" == "$oldBlockNumber" ]
then 
    ((err++))
else
    err=0
fi

if [ "$err" -gt 1 ] 
then
    echo "Mainnet blockNumber delay"|mail -v -s "BlockNumber Warnning" molin@wanchain.org
fi

sleep 5
oldBlockNumber=$blockNumber
echo $oldBlockNumber
done



