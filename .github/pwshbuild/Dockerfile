FROM mcr.microsoft.com/powershell:6.2.3-ubuntu-bionic

RUN apt-get update && apt-get install -y git

COPY * /
ENTRYPOINT ["pwsh", "/build.ps1"]