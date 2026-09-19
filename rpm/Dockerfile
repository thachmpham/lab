FROM fedora:44

# for rpm development
RUN dnf install -y rpmdevtools fedora-packager

# for troubleshoot, others
RUN dnf install -y sqlite vim rsyslog wget

CMD ["tail", "-f", "/dev/null"]