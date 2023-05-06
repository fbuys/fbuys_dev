FROM pierrezemb/gostatic
COPY ./dist/ /srv/http/


# Appended by flyctl
ENV ECTO_IPV6 true
ENV ERL_AFLAGS "-proto_dist inet6_tcp"
