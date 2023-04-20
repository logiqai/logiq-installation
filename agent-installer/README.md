# logiqcoll - agent
logiqcoll is logiq monitor data collector agent
It install and automatically configures the subject machine with fluent-bit, prometheus remote write agent, and OSSEC wazuh agent.
logiqcoll currently supports Ubuntu and Rasberry PI OS.

# logiqcoll.tgz is the installation agent tarball.  
## Follow the readme.txt instruction inside.

Mon Jan  2 23:26:02 PST 2023
- change new log mapping 
  cluster_id -> company name (fixed)
  namespace  -> department name (fixed)
  machine_id -> unique machine id
  hostname   -> hostname

Tue Dec 27 19:41:01 PST 2022
- run "sh build.sh" to generate logiqcoll.tgz for customer

Tue Dec 20 18:30:06 PST 2022

- One can tarball it for customer, e.g.
  % tar zcvf logiqcoll.tgz logiqcoll
- runs directory contains customer run directives


Tue Dec 13 23:47:27 PST 2022, pepe

- The script installs: td-agent-bit (fluent-bit), prometheus, prometheus-node-explor, OSSEC wazuh agent.

- The installation currently supports 
   1) Ubuntu 22.04 (Jammy) x86_64
   2) Ubuntu 20.04 (Focal) x86_64
   3) Debian Bullseye Arm64

- Steps to run it.
  1) Unzip the file and move to a desired installation location.
  2) % cd <install-location>/logiqcoll
  3) % ./logiqcollinstall --instauth ....

- One should manually run the command below prior to agent installation test sending json batch log record to the endpoint to make sure the ingestion end device is good to go.
    % <logiqcoll_path>/bin/ftf_linux_amd64 -https -notlsv -lhp 443 -host <endpoint> -it <ingest_key> -ingest -namespace sysmanager -ApplicationName logiqcoll -ProcessId 12345 -onemsg "test message"

- NOTE: 
  1) Note DO NOT run the installation under sudo.

  2) One needs to set parameters and this can be done via command arguments
     - logiq server end-point
     - OSSEC-agent manager ip
     - OSSEC-agent password 
     - ingest token
     - An example run shown below

       ./logiqcollinst \
        --instmap "1,1,1,1" \
        --endpoint "lq1234.logiq.ai" \
        --ossip "10.0.0.2" \
        --osspasswd "131f2348893789023" \
        --ingetoken "2323%&^*&asdfslkfjslfjskldfjlk245667" \
        --instauth 

  3) One can to set instmap (install mapper) for installing differrent agents:
    % ./logiqcollinst --help
      instmap map - x, x, x, x, x
      (td-agent-bit, prometheus, prometheus-node-explore, ossec-agent, ossec-vulnerability-scan)
      default instamap=1,1,1,0,0
      1 - on, 0 - off

  4) --instauth is to confirm to install agents 
