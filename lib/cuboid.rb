class Cuboid
  attr_reader :a1, :a2, :b1, :b2, :c1, :c2, :d1, :d2, :length, :height, :width

  def initialize(length, height, width)
    @a1 = [0, 0, 0]
    @a2 = [0, 0, width]
    @b1 = [0, height, 0]
    @b2 = [0, height, width]
    @c1 = [length, height, 0]
    @c2 = [length, height, width]
    @d1 = [length, 0, 0]
    @d2 = [length, 0, width]
    @length = length
    @height = height
    @width = width
    raise ArgumentError, 'Length, width and height can not be negative or 0' unless (width > 0 && length > 0 && height > 0)
  end

  # BEGIN public methods that should be your starting point

  def move_to!(x, y, z)
    @a1[0] = @a2[0] = @b1[0] = @b2[0] = x
    @a1[1] = @a2[1] = @d1[1] = @d2[1] = y
    @a1[2] = @b1[2] = @c1[2] = @d1[2] = z
    @a2[2] = @b2[2] = @c2[2] = @d2[2] = @a2[2] + z
    @b1[1] = @b2[1] = @c1[1] = @c2[1] = @b2[1] + y
    @c1[0] = @c2[0] = @d1[0] = @d2[0] = @d2[0] + x
    self
  end

  def vertices
    [@a1, @a2, @b1, @b2, @c1, @c2, @d1, @d2]
  end

  def intersects?(other)
    self_cuboid_points = point_calculation(@a1, @length, @height, @width)
    other_cuboid_points = point_calculation(other.a1, other.length, other.height, other.width)
    intersecting = {}
    intersecting[:x] = self_cuboid_points[:axis_x] & other_cuboid_points[:axis_x]
    intersecting[:y] = self_cuboid_points[:axis_y] & other_cuboid_points[:axis_y]
    intersecting[:z] = self_cuboid_points[:axis_z] & other_cuboid_points[:axis_z]
    intersecting.value?([]) ? false : true
  end

  private

  def point_calculation(a1, length, height, width)
    result = { axis_x: [], axis_y: [], axis_z: [] }
    (0..length).to_a.each do |x|
      result[:axis_x] << a1[0] + x
    end
    (0..height).to_a.each do |y|
      result[:axis_y] << a1[1] + y
    end
    (0..width).to_a.each do |z|
      result[:axis_z] << a1[2] + z
    end
    result
  end
end
