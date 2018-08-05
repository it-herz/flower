FROM python:3.6.6-alpine3.6

# Get latest root certificates
RUN apk add --update ca-certificates && update-ca-certificates

RUN apk add tzdata && ls /usr/share/zoneinfo && cp /usr/share/zoneinfo/Europe/Moscow /etc/localtime && echo "Europe/Moscow" >  /etc/timezone

# Install the required packages
RUN pip install redis flower

# PYTHONUNBUFFERED: Force stdin, stdout and stderr to be totally unbuffered. (equivalent to `python -u`)
# PYTHONHASHSEED: Enable hash randomization (equivalent to `python -R`)
# PYTHONDONTWRITEBYTECODE: Do not write byte files to disk, since we maintain it as readonly. (equivalent to `python -B`)
ENV PYTHONUNBUFFERED=1 PYTHONHASHSEED=random PYTHONDONTWRITEBYTECODE=1

# Default port
EXPOSE 5555

# Run as a non-root user by default, run as user with least privileges.
USER nobody

ENTRYPOINT ["flower"]
