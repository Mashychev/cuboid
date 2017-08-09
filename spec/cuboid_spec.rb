require 'cuboid'

#This test is incomplete and, in fact, won't even run without errors.  
#  Do whatever you need to do to make it work and please add your own test cases for as many
#  methods as you feel need coverage
describe Cuboid do
  subject { Cuboid.new(2, 3, 6) }

  describe 'initialize' do
    it 'returns a Cuboid object' do
      expect(subject.move_to!(1, 2, 3)).to be_an_instance_of Cuboid
    end

    it 'returns argument error if dimensions are negative or 0' do
      expect{ Cuboid.new(-2, -1, -1) }.to raise_error(ArgumentError, 'Length, width and height can not be negative or 0')
    end
  end
 
  describe "move_to" do
    it "should change origin with negative coordinates" do
      expect(subject.move_to!(-2, -2, -3).b2).to eq([-2, 1, 3])
    end

    it 'should change origin' do
      expect(subject.move_to!(1, 2, 3).a1).to eq([1, 2, 3])
    end
  end

describe 'vertices' do
  it 'show array of vertices' do
    expect(subject.vertices).to be_an Array
  end
end

  describe "intersects?" do
    it 'should detect intersection between cuboids' do
      expect(subject.intersects?(Cuboid.new(10, 8, 7).move_to!(1, 2, 4))).to be true
    end

    it 'should not detect intersection between cuboids' do
      expect(subject.intersects?(Cuboid.new(1, 4, 2).move_to!(10, 10, 10))).to be false
    end
  end
end
