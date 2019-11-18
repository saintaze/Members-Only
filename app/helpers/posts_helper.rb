module PostsHelper

  def border_color(index)
    border_colors = %w[primary success danger warning dark]  
    border_colors[index % border_colors.length]
  end

end
