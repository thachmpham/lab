FROM fedora:44

RUN dnf group install -y rpm-development-tools

RUN dnf group install -y c-development
RUN dnf install -y sqlite rsyslog
RUN dnf install -y man-db man-pages tree

RUN rpmdev-setuptree

CMD ["tail", "-f", "/dev/null"]