# base docker file
FROM daocloud.io/geyijun/open_resty_common:v0.31
MAINTAINER limanman<xmdevops@vip.qq.com>

# copy files 
COPY idmap.conf /xm_workspace/xmcloud3.0/upgradeserver_lua/
COPY geoip.mmdb /xm_workspace/xmcloud3.0/upgradeserver_lua/
COPY manage.py /xm_workspace/xmcloud3.0/upgradeserver_lua/
COPY requirements.txt /xm_workspace/xmcloud3.0/upgradeserver_lua/
COPY upgradeserver_lua /xm_workspace/xmcloud3.0/upgradeserver_lua/
COPY nginx.conf /usr/local/openrestry/nginx/conf/

# install envirment
RUN yum -y install epel-release
RUN yum -y install python-devel python-pip
RUN pip install -r /xm_workspace/xmcloud3.0/upgradeserver_lua/requements.txt

# make log dirs
RUN mkdir /xm_workspace/xmcloud3.0/upgradeserver_lua/logs/nginx
RUN mkdir /xm_workspace/xmcloud3.0/upgradeserver_lua/logs/upgradeserver_lua

# supervisord
COPY supervisord.conf /etc/supervisord.conf 

# run settings
WORKDIR /xm_workspace/xmcloud3.0/upgradeserver_lua/
EXPOSE 8802
CMD ["supervisord"]
