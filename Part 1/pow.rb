def calc_nonce
  nonce = "HELP I'M TRAPPED IN A NONCE FACTORY"
  count = 0
  until is_valid_nonce?(nonce)
    print "." if count % 100_000 == 0
    nonce = nonce.next
    count += 1
  end
  nonce
end
