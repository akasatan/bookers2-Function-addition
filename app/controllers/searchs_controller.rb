class SearchsController < ApplicationController
      
  def search
    @content = params[:content]
    @model = params[:model]
    @method = params[:method]
    if @model == 'user'
      @records = User.search(@content, @method)
    else
      #titleだけヒットするようにしているよ
      @records = Book.search(@content, @method)
    end
  end
  
end
