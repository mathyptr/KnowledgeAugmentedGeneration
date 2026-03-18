# Dockerfile built from OpenSPG's dockerfile (see https://github.com/OpenSPG/openspg for the licensed and the Copyright of the original files)

FROM ubuntu:20.04

# For apt to be noninteractive
ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true
ENV LANG C.UTF-8
ENV PATH=/home/admin/miniconda3/bin:$PATH

#ARG TARGETPLATFORM=

ARG APT_INSTALL="apt-get install --no-install-recommends -y"
ARG MINICONDA_VERSION=py310_25.1.1-2
ARG MINICONDA_FILE=Miniconda3-${MINICONDA_VERSION}-Linux-x86_64.sh

RUN apt-get clean && apt-get update && \
    $APT_INSTALL ca-certificates && \
    $APT_INSTALL ca-certificates-java && \
    $APT_INSTALL git less vim wget curl telnet nano jq procps net-tools unzip zip tar gzip nfs-common && \
    # Install openjdk 8.
    $APT_INSTALL openjdk-8-jdk && \
    update-alternatives --set java /usr/lib/jvm/java-8-openjdk-$(dpkg --print-architecture)/jre/bin/java && \
#    update-alternatives --set java /usr/lib/jvm/java-8-openjdk-`echo $TARGETPLATFORM | cut -d'/' -f2`/jre/bin/java
    # Install build / source control tools
    $APT_INSTALL wget git maven less vim

RUN export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64; \
echo "export JAVA_HOME=${JAVA_HOME}" >> /etc/profile

RUN . /etc/profile && echo ${JAVA_HOME} && mkdir -p /home/admin/ && chmod -R 777 /home/admin &&\
    # wget -q http://hyperloop.cn-hangzhou.alipay.aliyun-inc.com/kgrl/user/zhongshu.zzs/tmp/Miniconda3-py310_25.1.1-2-Linux-x86_64.sh && \
    wget -q https://repo.anaconda.com/miniconda/$MINICONDA_FILE && \
    ln -s /usr/bin/md5sum /usr/bin/md5 &&\
    bash $MINICONDA_FILE -b -u -p /home/admin/miniconda3 &&\
    rm -rf $MINICONDA_FILE && \
    /home/admin/miniconda3/bin/conda init &&\
    pip install openspg-kag==0.8.0 &&\
    pip install pemja==0.4.0 && \
    pip cache purge

EXPOSE 8887

RUN mv /home/admin/miniconda3/lib/python3.10/site-packages/kag/builder/component/extractor/knowledge_unit_extractor.py /home/admin/miniconda3/lib/python3.10/site-packages/kag/builder/component/extractor/knowledge_unit_extractor.pyOLD
#ADD build/issue/knowledge_unit_extractor.py /home/admin/miniconda3/lib/python3.10/site-packages/kag/builder/component/extractor/
#ADD build/target/arks-sofaboot-0.0.1-SNAPSHOT-executable.jar /

RUN wget  https://github.com/mathyptr/KnowledgeAugmentedGeneration/archive/refs/heads/master.zip
RUN (unzip master.zip KnowledgeAugmentedGeneration-master/KAG/server-jar/* && cat KnowledgeAugmentedGeneration-master/KAG/server-jar/arks-sofaboot-0.0.1-SNAPSHOT-executable.jar_* > /arks-sofaboot-0.0.1-SNAPSHOT-executable.jar)
RUN (unzip master.zip KnowledgeAugmentedGeneration-master/KAG/issue/knowledge_unit_extractor.py && cp KnowledgeAugmentedGeneration-master/KAG/issue/knowledge_unit_extractor.py /home/admin/miniconda3/lib/python3.10/site-packages/kag/builder/component/extractor/ )
RUN (rm master.zip && rm -r KnowledgeAugmentedGeneration-master)


ENTRYPOINT ["java", "-jar", "arks-sofaboot-0.0.1-SNAPSHOT-executable.jar"]
