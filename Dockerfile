FROM fpco/stack-build as builder
COPY . .
RUN stack install

FROM ubuntu
COPY --from=builder /root/.local/bin/funky-birthdays /usr/bin/
CMD ["funky-birthdays"]