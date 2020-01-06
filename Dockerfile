FROM base:latest

ENV DOTNET_VER=3.1.0 DOTNET_ARCH=x64

LABEL maintainer=Roxedus
LABEL dotnet_version=${DOTNET_VER}

RUN \
 apk add --no-cache --virtual=run-deps \
    libstdc++ \
    libgcc \
    icu-libs \
    libintl \
	tar

RUN \
  wget -O dotnet.tar.gz https://dotnetcli.azureedge.net/dotnet/Runtime/${DOTNET_VER}/dotnet-runtime-${DOTNET_VER}-linux-musl-x64.tar.gz \
  && mkdir -p /usr/share/dotnet \
  && tar -C /usr/share/dotnet -oxzf dotnet.tar.gz \
  && ln -s /usr/share/dotnet/dotnet /usr/bin/dotnet \
  && rm dotnet.tar.gz

RUN \
  wget https://download.technitium.com/dns/DnsServerPortable.tar.gz && \
  tar -zxf DnsServerPortable.tar.gz -C /app


WORKDIR /app

COPY root/ /