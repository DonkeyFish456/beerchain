require 'colorize'
require 'digest'


class Block
  attr_reader :own_hash, :prev_block_hash

  def initialize(prev_block, beer)
  end

  def mine_block!
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
  end

  def hash(contents)
  end
end


class BlockChain
  attr_reader :blocks

  def initialize(beer)
  end

  def add_to_chain(beer)
  end

  def to_s
    @blocks.map(&:to_s).join("\n")
  end
end

b = BlockChain.new("---Genesis Block---")
b.add_to_chain("Dos XX")
b.add_to_chain("Dos XX")
b.add_to_chain("Dos XX")
