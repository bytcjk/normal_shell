#=====-------线上脚本 ------start -------------
nohup sudo /usr/bin/python /usr/local/bin/ssserver -c /usr/local/etc/shadowsocks.json -d restart >/dev/null 2>&1 &
#start kcptun
 nohup  /usr/local/src/server_linux_amd64 -c /usr/local/etc/kcp_server.json >>/var/log/kcp_server.log 2>&1 &
 nohup  /usr/local/src/server_linux_amd64 -c /usr/local/etc/kcp_server_bak.json >>/var/log/kcp_server.log 2>&1 &
 nohup /usr/local/src/server_linux_amd64 -c /usr/local/etc/kcp_server_7279.json >>/var/log/kcp_server.log 2>&1 &
#start nethogs
/home/baijingdong/shell/nethogs_daily_schdule.sh >/dev/null 2>&1 &
/home/baijingdong/shell/nethogs_speed_schdule.sh  >/dev/null 2>&1 &
# start graphite
nohup sudo /usr/bin/python /opt/graphite/bin/carbon-cache.py start >/dev/null 2>&1 &
nohup sudo /usr/bin/python /usr/bin/django-admin.py runserver --pythonpath /opt/graphite/webapp --settings graphite.settings 0.0.0.0:8085 >/dev/null 2>&1 &
# 监测流量
nohup /bin/bash /opt/graphite/bin/net_shell.sh >/dev/null 2>&1 &
nohup /bin/bash /opt/graphite/bin/net_shell_total.sh  >/dev/null 2>&1 &
#log_num interval
nohup /usr/bin/php /home/baijingdong/shell/shadowsocks_info_stats_cycle.php  `wc -l /var/log/shadowsocks.log`  >/dev/null 2>&1 &
 nohup /usr/bin/php /home/baijingdong/shell/kcptun_req_stats.php `wc -l /var/log/kcp_server.log` >/dev/null 2>&1 &

# start nginx
sudo /usr/local/openresty/nginx/sbin/nginx -p /usr/local/nginx/ -c conf/nginx.conf
#start php-workerman-chat
nohup /usr/bin/php /home/baijingdong/workerman-chat/start.php start >/dev/null 2>&1 &
#start rsync
sudo  /etc/init.d/rsync start
#start InterIj
sudo nohup /home/baijingdong/IntelliJIDEALicenseServer_linux_amd64  >/dev/null 2>&1 &
sudo  /etc/init.d/grafana-server start
sudo  zabbix_agentd
sudo  zabbix_server
cd /etc/wireguard/ && sudo  wg-quick up wg1  && sudo wg-quick up wg2
#last execute
  nohup /home/baijingdong/shell/ShadowSocks_Stats.py -f /var/log/shadowsocks.log >/dev/null 2>&1 &
  nohup /home/baijingdong/shell/ShadowSocks_Stats.py -f /var/log/shadowsocks.log -t 2 >/dev/null 2>&1 &
 nohup /home/baijingdong/shell/ShadowSocks_Stats.py -f /var/log/shadowsocks.log -t 3 >/dev/null 2>&1 & 
 nohup /home/baijingdong/shell/ShadowSocks_Stats.py -f /var/log/shadowsocks.log -t 4 >/dev/null 2>&1 & 
#=====-------线上脚本 ------end -------------
