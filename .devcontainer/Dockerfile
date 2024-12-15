# Update VARIANT in devcontainer.json to pick a Dart version
ARG VARIANT=3.6
FROM dart:${VARIANT}

# Add bin location to path
# ENV PUB_CACHE="/usr/local/share/pub-cache"
# ENV PATH="${PUB_CACHE}/bin:${PATH}"
# RUN if ! cat /etc/group | grep -e "^pub-cache:" > /dev/null 2>&1; then groupadd -r pub-cache; fi \
#     && usermod -a -G pub-cache ${USERNAME} \
#     && umask 0002 \
#     && mkdir -p ${PUB_CACHE} \
#     && chown :pub-cache ${PUB_CACHE} \
#     && sed -i -e "s/export PATH=/export PATH=\/usr\/local\/share\/pub-cache:/" /etc/profile.d/00-restore-env.sh \
#     #
#     # Fix incorrect privs if present on directories - https://github.com/dart-lang/dart-docker/issues/62, https://github.com/dart-lang/sdk/issues/47093
#     && chmod 755 "$DART_SDK" "$DART_SDK/bin"

# [Optional] Uncomment this section to install additional OS packages.
# RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
#     && apt-get -y install --no-install-recommends <your-package-list-here>