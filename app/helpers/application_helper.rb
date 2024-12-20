module ApplicationHelper
  # Helper kiểm tra URL và trả về lớp "active" nếu URL hiện tại khớp với đường dẫn
  def active_class(link_path)
    current_page?(link_path) ? 'active' : ''
  end

  # Helper để kiểm tra các URL tương tự nhau
  def active_class_for_pattern(pattern)
    request.path.match?(pattern) ? 'active' : ''
  end
end
