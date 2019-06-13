############################################################################
# (C) Copyright IBM Corporation 2018, 2019                                      #
#                                                                          #
# Licensed under the Apache License, Version 2.0 (the "License");          #
# you may not use this file except in compliance with the License.         #
# You may obtain a copy of the License at                                  #
#                                                                          #
#      http://www.apache.org/licenses/LICENSE-2.0                          #
#                                                                          #
# Unless required by applicable law or agreed to in writing, software      #
# distributed under the License is distributed on an "AS IS" BASIS,        #
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. #
# See the License for the specific language governing permissions and      #
# limitations under the License.                                           #
#                                                                          #
############################################################################

FROM ibmcom/websphere-traditional:9.0.0.11

LABEL maintainer="Scott Kurz <skurz@us.ibm.com>"

#
# Run admin scripts one-by-one
#

# 0. Copy to a different name so it doesn't get run with every invocation to configure.sh
COPY --chown=was:root was-config.props /work/config/config.properties

# 1. Enable application security (using the same wsadmin id as userid)
COPY --chown=was:root security.py /work/config/
RUN /work/configure.sh /work/config/security.py

# 2. Configure JVM args to enable debug mode
RUN work/applyConfig.sh /work/config/config.properties

# 3. Enable application security (using the same wsadmin id as userid)
COPY --chown=was:root monitoredApp.py /work/config/
RUN /work/configure.sh /work/config/monitoredApp.py
