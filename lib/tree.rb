# frozen_string_literal: true

require_relative 'node'

class Tree
  attr_reader :root

  def initialize(data_array = [])
    @root = _build_tree(data_array.uniq.sort)
  end

  def insert(value)
    @root = _insert_node(@root, value)
  end

  def delete(value)
    @root = _delete_node(@root, value)
  end

  def find(value)
    _find_node(@root, value)
  end

  def height(value)
    node = find(value)
    return nil if node.nil?

    _height_node(node)
  end

  def depth(value)
    node = find(value)
    return nil if node.nil?

    _depth_node(@root, value)
  end

  def balanced?
    _balanced_tree?(@root)
  end

  def rebalance
    sorted_tree = inorder
    @root = _build_tree(sorted_tree)
  end

  def level_order_i(&block)
    queue = [@root]
    result = []
    _level_order_iteration(@root, queue, result, &block)
  end

  def level_order_r(&block)
    queue = [@root]
    result = []
    _level_order_recursion(queue, result, &block)
  end

  def preorder(&block)
    result = []
    _preorder_traversal(@root, result, &block)
  end

  def inorder(&block)
    result = []
    _inorder_traversal(@root, result, &block)
  end

  def postorder(&block)
    result = []
    _postorder_traversal(@root, result, &block)
  end

  # Method written and shared on Discord by another student
  def pretty_print(node = @root, prefix = '', is_left = true)
    return if node.nil?

    new_prefix = prefix + (is_left ? '│   ' : '    ')
    pretty_print(node.right, new_prefix, false)

    connector = is_left ? '└── ' : '┌── '
    puts "#{prefix}#{connector}#{node.data}"

    new_prefix = prefix + (is_left ? '    ' : '│   ')
    pretty_print(node.left, new_prefix, true)
  end

  private

  def _build_tree(data_array)
    return nil if data_array.empty?

    # Integer division in ruby always returns an integer
    half = data_array.length / 2
    root = Node.new(data_array[half])
    root.left  = _build_tree(data_array[0...half])
    root.right = _build_tree(data_array[(half + 1)..])

    root
  end

  def _insert_node(node, value)
    return Node.new(value) if node.nil?
    return node if node.data == value

    if value < node.data
      node.left = _insert_node(node.left, value)
    else
      node.right = _insert_node(node.right, value)
    end

    node
  end

  def _delete_node(node, value)
    return nil if node.nil?

    if value < node.data
      node.left  = _delete_node(node.left,  value)
    elsif value > node.data
      node.right = _delete_node(node.right, value)
    else
      return node.left  if node.right.nil?
      return node.right if node.left.nil?

      successor = _get_successor(node)
      node.data = successor.data
      node.right = _delete_node(node.right, successor.data)
    end

    node
  end

  def _get_successor(node)
    node = node.right
    node = node.left while !node.nil? && !node.left.nil?

    node
  end

  def _find_node(node, value)
    return nil  if node.nil?
    return node if node.data == value

    if value < node.data
      _find_node(node.left,  value)
    else
      _find_node(node.right, value)
    end
  end

  def _height_node(node)
    # Base case: a nil node has height "-1"
    return -1 if node.nil?

    height_left  = _height_node(node.left)
    height_right = _height_node(node.right)
    1 + [height_left, height_right].max
  end

  def _depth_node(node, value, depth = 0)
    return depth if node.data == value

    if value < node.data
      _depth_node(node.left,  value, depth + 1)
    else
      _depth_node(node.right, value, depth + 1)
    end
  end

  def _balanced_tree?(node)
    return true if node.nil?

    height_left  = _height_node(node.left)
    height_right = _height_node(node.right)
    height_diff  = (height_left - height_right).abs <= 1

    balanced_subtree = _balanced_tree?(node.left) && _balanced_tree?(node.right)
    height_diff && balanced_subtree
  end

  def _level_order_iteration(root, queue, result)
    return result if root.nil?

    until queue.empty?
      node = queue.shift

      block_given? ? yield(node) : result << node.data
      queue << node.left  if node.left
      queue << node.right if node.right
    end

    result unless block_given?
  end

  def _level_order_recursion(queue, result, &block)
    return result if queue.empty?

    node = queue.shift
    return if node.nil?

    block_given? ? (yield node) : result << node.data
    queue << node.left  if node.left
    queue << node.right if node.right
    _level_order_recursion(queue, result, &block)

    result unless block_given?
  end

  def _preorder_traversal(node, result, &block)
    return result if node.nil?

    block_given? ? (yield node) : result << node.data
    _preorder_traversal(node.left,  result, &block)
    _preorder_traversal(node.right, result, &block)

    result unless block_given?
  end

  def _inorder_traversal(node, result, &block)
    return result if node.nil?

    _inorder_traversal(node.left, result, &block)
    block_given? ? (yield node) : result << node.data
    _inorder_traversal(node.right, result, &block)

    result unless block_given?
  end

  def _postorder_traversal(node, result, &block)
    return result if node.nil?

    _postorder_traversal(node.left,  result, &block)
    _postorder_traversal(node.right, result, &block)
    block_given? ? (yield node) : result << node.data

    result unless block_given?
  end
end
