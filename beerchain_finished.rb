require 'colorize'
require 'digest'

class Block
  attr_reader :own_hash, :prev_block_hash

  def initialize(prev_block, beer)
    @beer = beer
    @prev_block_hash = prev_block.own_hash if prev_block
    mine_block!
  end

  def mine_block!
    @own_hash = hash(full_block)
  end

  def to_s
    [
      "",
      "-" * 80,
      "Previous hash: ".rjust(15) + @prev_block_hash.to_s.yellow,
      "Beer: ".rjust(15) + @beer.green,
      "Own hash: ".rjust(15) + @own_hash.yellow,
      "-" * 80,
      "|".rjust(40),
      "|".rjust(40),
      "↓".rjust(40),
    ].join("\n")
  end



  private


  def full_block
    [@beer, @prev_block_hash].compact.join
  end

  def hash(contents)
    Digest::SHA256.hexdigest(contents)
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

  def to_s
    @blocks.map(&:to_s).join("\n")
  end
end

b = BlockChain.new("---Genesis Block---")
b.add_to_chain("Dos XX")
b.add_to_chain("Dos XX")
b.add_to_chain("IPA")
