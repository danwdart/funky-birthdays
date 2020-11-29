FROM dandart/funky-birthdays:build as builder
RUN stack install

FROM ubuntu
COPY --from=builder /root/.local/bin/funky-birthdays /usr/bin/
CMD ["funky-birthdays"]