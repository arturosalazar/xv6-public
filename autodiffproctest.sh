(
sleep 12



echo automemtest
sleep 1



echo automemtestdealloc
sleep 1



echo automemtest &
sleep 1
echo automemtest
sleep 1



echo automemtestdealloc &
sleep 1
echo automemtestdealloc &
) | make qemu