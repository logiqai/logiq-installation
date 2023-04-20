Thu Jan 19 18:06:17 PST 2023

   * DNS lookup failure resolved by
     checking file /etc/resolv.conf and /etc/dhcpcd.conf
   * make sure illegle dns server address isn't there.

Wed Jan 18 11:56:16 PST 2023
    Major updates:
    ===================
    * concise output and verbose mode
    * remap fluent-bit to make logging scalable
    * add "<cluster_id>_<namespace>" to prometheus metrics group
    * add fluent-bit exporter
    * change fluent-bit storage buffer configuration

Wed Jan  4 14:36:15 PST 2023

- remove installation files
  all files are based on install and wget.
- the tgz is now 10k!
- Uses MAC address for uniq id 

Tue Dec 13 23:47:27 PST 2022

- The script installs: td-agent-bit (fluent-bit), prometheus, prometheus-node-explor, OSSEC wazuh agent.

- The installation currently supports 
   1) Ubuntu 22.04 (Jammy) x86_64
   2) Ubuntu 20.04 (Focal) x86_64
   3) Raspberry pi (Bullseye) Arm64
   4) Raspberry pi (Buster) Arm64

- Steps to run it.
  1) Unzip the file and move to a desired installation location.
     % tar zxvf logiqcol.tgz
  2) % cd <install-location>/logiqcoll
  3) run the command with all the necessary argument or run the "run.sh" shell command
     % ./logiqcollinstall --instauth ....
     or
     % ~/run.sh

     An example run.sh below

 =======
       ./logiqcollinst \
        --instmap "1,1,1,1,0" \
        --endpoint "lq1234.logiq.ai" \
        --ossip "10.0.0.2" \
        --osspasswd "131f2348893789023" \
        --ingetoken "2323%&^*&asdfslkfjslfjskldfjlk245667" \
        --instauth 
        --cluster_id logiq \
        --namespace engr \
        --tenant_id customer_id \
        --tenant tenant_1  


- NOTE: 
  1) The user should have sudo priledge
  2) Do not run the command from root account
  3) DO NOT run the installation under sudo, e.g. NO "sudo ./logiqcollinst ...".
  4) The user needs to set the necessary parameters such as credential and endpoints for data ingestion
     - logiq server end-point, e.g. company_name.logiq.ai
     - OSSEC-agent manager ip address.
     - OSSEC-agent password credential
     - ingest token credential

  5) One can to set instmap (install mapper) for installing differrent agents:
    % ./logiqcollinst --help
      instmap map - x, x, x, x, x
      (td-agent-bit, prometheus, prometheus-node-explore, ossec-agent, ossec-vulnerability-scan)
      default instamap=1,1,1,0,0
      1 - on, 0 - off

  6) --instauth is to confirm to install the agent 

Thu Apr  6 18:09:30 PDT 2023
   * Sending installation log to endpoint
   * Adding tft utility binary for amd64 and arm64

Wed Apr 19 22:13:42 PDT 2023

  * One should manually run the command below prior to agent installtation to test sending json batch log record to the endpoint to make 
    sure the ingestion end device is good to go.

    % <logiqcoll_path>/bin/ftf_linux_amd64 -https -notlsv -lhp 443 -host <endpoint> -it <ingest_key> -ingest -namespace sysmanager -ApplicationName logiqcoll -ProcessId 12345 -onemsg "test message"


