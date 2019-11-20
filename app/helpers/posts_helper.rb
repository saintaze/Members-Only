module PostsHelper

  def border_color(index)
    # border_colors = %w[primary success danger warning dark]  
    border_colors = %w[primary danger success warning dark]  
    if @view == 'story'
      index = params[:page].nil? ? 0 : params[:page].to_i - 1
      return border_colors[index % border_colors.length]
    end
    border_colors[index % border_colors.length]
  end

  def post_arrow_nav
    return if Post.count == 0
    @posts_count ||= Post.count.to_f
    @posts_per_page ||= 1
    @post_pages ||= (@posts_count / @posts_per_page).ceil
    @page = params[:page] ? params[:page].to_i : 1
    @posts ||= Post.offset((@page * @posts_per_page) - @posts_per_page).limit(@posts_per_page)
    @posts_served = @page * @posts_per_page
    @posts_remaining = @posts_count.to_i - @posts_served <= 0 ? 0 : @posts_count.to_i - @posts_served
  end

  def post_pagination_nav(max_pages: 7, posts_per_page: 6)
    return if Post.count == 0
    @posts_count ||= Post.count.to_f
    @max_pages = max_pages
    @posts_per_page ||= posts_per_page
    @total_pages ||= @posts_per_page >= @posts_count ? 1 : (@posts_count / @posts_per_page).ceil
    @page_num = params[:page].to_i == params[:last_page].to_i ? params[:page].to_i + 1 : params[:page].to_i
    @posts ||= Post.offset((@page_num * @posts_per_page) - @posts_per_page).limit(@posts_per_page)
    @posts_served = @page_num * @posts_per_page
    @last_page = params[:last_page].to_i
    @remaining_total_pages = @total_pages - @last_page
    @pages_to_show = @remaining_total_pages > @max_pages ? @max_pages : @remaining_total_pages
    @starting_page = @last_page + 1
    @ending_page = (@starting_page + @pages_to_show) - 1
    @posts_remaining = @posts_count.to_i - @posts_served <= 0 ? 0 : @posts_count.to_i - @posts_served
  end

end
