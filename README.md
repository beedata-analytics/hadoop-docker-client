# hadoop-docker-client

```bash
docker run -it --user 1000:1000 -v /usr/hdp/current/hadoop-mapreduce-client/bin/mapred:/usr/hdp/current/hadoop-mapreduce-client/bin/mapred -v /usr/hdp/3.1.4.0-315:/usr/hdp/3.1.4.0-315 -v /usr/hdp/3.1.4.0-315/hadoop/conf:/usr/local/hadoop/conf -v /usr/jdk64:/usr/jdk64 -v /etc:/etc -v /etc/hosts:/etc/hosts local/hadoop-docker-client
```
