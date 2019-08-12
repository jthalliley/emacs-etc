#!/usr/bin/python

"""
How to get build from job and query that build
"""
from __future__ import print_function
from jenkinsapi.jenkins import Jenkins

JENKINS_URL  = 'https://jenkins.creditacceptance.com'
JENKINS_USER = 'jhalliley'
JENKINS_PW   = 'Emacs4Me!'

def get_server_instance():
    server = Jenkins(JENKINS_URL, username=JENKINS_USER, password=JENKINS_PW)
    return server


if __name__ == '__main__':
    print(get_server_instance().version)

jenkins = Jenkins(JENKINS_URL, username=JENKINS_USER, password=JENKINS_PW)


# Print all jobs in Jenkins
# print(jenkins.items())

job = jenkins.get_job('Originations/orig-caps2')
build = job.get_last_build()
print(build)
exit()

"""
mjn = build.get_master_job_name()
print(mjn)
"""

"""
if job exists, great
if not, create it

"""

repos = [ \
          "ancillary-service" \
          "applicant-service" \
          "bureausmonthoftest" \
          "caps2" \
          "caps2-authws" \
          "caps2-batchjobs" \
          "caps2-bbook-autocheck" \
          "caps2-bureaus" \
          "caps2-cacauth" \
          "caps2-carletonsmartcalcs" \
          "caps2-casemanagement" \
          "caps2-combinedbureaus" \
          "caps2-dealertrack" \
          "caps2-domain" \
          "caps2-gpssid" \
          "caps2-inventory" \
          "caps2-lead" \
          "caps2-liquibase" \
          "caps2-routeone" \
          "caps2-routeonebatch" \
          "caps2-scorecard-advance" \
          "caps2-util" \
          "caps2-work-number-integration" \
          "caps2aggregator" \
          "contract-interface" \
          "contract-interfaces-domain" \
          "credit-report-parsing-service" \
          "customerhub-service-client" \
          "dealer-interface" \
          "dealer-interfaces-domain" \
          "dealer-service" \
          "document-service" \
          "econtracting" \
          "inventory-ingest" \
          "inventory-management" \
          "inventory-service" \
          "lead-service" \
          "originations-ui" \
          "paymentus-gateway" \
          "policy-service" \
          "rule-service" \
          "scoring-engine" \
          "step3-capture-consumer" \
          "vehicle-loan-application-service" \
]


# curl -X GET http://jenkins.creditacceptance.com/api/json?pretty=true --user 'jhalliley:W10CantStopMe!'
