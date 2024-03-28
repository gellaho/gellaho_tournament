# frozen_string_literal: true

module ApplicationHelper
  def icon(symbol, text = '')
    return render("icons/#{symbol}") unless text.present?

    content_tag(:div, class: "flex flex-row gap-1 items-center") do
      render("icons/#{symbol}").concat(text)
    end
  end

  def button(*, **kwargs, &)
    klass = "py-2 px-3 rounded w-fit shadow-md #{kwargs.fetch(:class, 'bg-emerald-600 text-white')}"
    kwargs[:class] = klass
    button_tag(*, kwargs, &)
  end

  def button_link(text, *, **kwargs, &)
    klass = "py-2 px-3 rounded w-fit shadow-md #{kwargs.fetch(:class, 'bg-emerald-600 text-white')}"
    kwargs[:class] = klass
    link_to(text, *, kwargs, &)
  end

  def link_nav(path, text = nil, &)
    if current_page?(path)
      content_tag(:span, text, class: ' bg-emerald-400 text-white px-2 py-1 rounded', &)
    elsif text
      link_to(text, path, class: 'text-blue-600 hover:text-black hover:bg-emerald-100 px-2 py-1 rounded')
    else
      link_to(path, class: 'text-blue-600 hover:text-black hover:bg-emerald-100 px-2 py-1 rounded', &)
    end
  end
end
