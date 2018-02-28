require 'colorize'
require 'digest'
require 'pry'

class Block
  NUM_ZEROES = 5
  attr_reader :own_hash, :prev_block_hash

  def initialize(prev_block, beer)
    @beer = beer
    @prev_block_hash = prev_block.own_hash if prev_block
    mine_block!
  end

  def mine_block!
    @nonce = calc_nonce
    @own_hash = hash(full_block(@nonce))
  end

  def valid?
    is_valid_nonce?(@nonce)
  end

  def to_s
    [
      "",
      "-" * 80,
      "Previous hash: ".rjust(15) + @prev_block_hash.to_s.yellow,
      "Beer: ".rjust(15) + @beer.green,
      "Nonce: ".rjust(15) + @nonce.red,
      "Own hash: ".rjust(15) + @own_hash.yellow,
      "-" * 80,
      "|".rjust(40),
      "|".rjust(40),
      "↓".rjust(40),
    ].join("\n")
  end



  private


  def full_block(nonce)
    [@beer, @prev_block_hash, nonce].compact.join
  end

  def hash(contents)
    Digest::SHA256.hexdigest(contents)
  end

  def calc_nonce
    nonce = "How many beers should i get?"
    count = 0
    until is_valid_nonce?(nonce)
      print "." if count % 100_000 == 0
      nonce = nonce.next
      count += 1
    end
    nonce
  end

  def is_valid_nonce?(nonce)
    hash(full_block(nonce)).start_with?("0" * NUM_ZEROES)
  end
end



class BlockChain
  attr_reader :blocks

  def initialize(beer)
    @blocks = []
    @blocks << Block.new(nil, beer)
  end

  def add_to_chain(beer)
    @blocks << Block.new(@blocks.last, beer)
    puts @blocks.last
  end

  def valid?
    @blocks.all? { |block| block.is_a?(Block) } &&
      @blocks.all?(&:valid?) &&
      @blocks.each_cons(2).all? { |a, b| a.own_hash == b.prev_block_hash }
  end

  def to_s
    @blocks.map(&:to_s).join("\n")
  end
end

b = BlockChain.new("---Genesis Block---")
b.add_to_chain("Dos XX")
b.add_to_chain("Dos XX")
b.add_to_chain("IPA")

puts b.valid?
