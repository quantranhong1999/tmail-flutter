- only for testing
- Start by provision a TMail user:
`docker exec -it tmail-backend-testing james-cli AddUser bob@domain.tld bobpassword`
- Then you can play with either TMail Web client (JMAP) or Thunderbird (SMTP + IMAP)
  For TMail web, please open localhost:8080