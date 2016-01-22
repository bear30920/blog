class ArticlesController < ApplicationController
    def index
        @articles = Article.all
        #all方法會article model抓出所有article 的文章
        #index 字元要是變複數
        if params[:title].present?
            #當你在搜尋標題,欄位才會起作用
            @articles=@articles.where("title like ?","%#{params[:title]}%")
            # title like 搜尋tilte 像??
            #SQL語法加上％只要前後有相似的字會抓出來
        end
        
        if params[:content].present?
            @articles=@articles.where("content like ?","%#{params[:content]}%")
        end

    end

    def show
        @article = Article.find(params[:id])
        #宣告變數 從article model去搜尋所對應網頁的參數ID
    end

    def new
        @article = Article.new
        #宣告變數為新的article model的實例
    end

    def create
        @article = Article.new(article_params)
        #宣告article變數
        #article_params接收表單寫的參數
        #從article model新增出來
        if @article.save
            #收到true新的資訊儲存起來
            #save 會回傳 true or false
            redirect_to root_path
            #存成功轉到首頁
        else
            render :new
            #存失敗 繼續呈現new的頁面
        end
    end

    def edit
        @article = Article.find(params[:id])
          #宣告變數 從article model去搜尋所對應網頁的參數ID
    end

    def update
        @article = Article.find(params[:id])
        #宣告變數 從article model去搜尋所對應網頁的參數ID
        if @article.update(article_params)
            #使用update方法
            #article_params更新表單寫的參數
            redirect_to root_path
        else
            render :edit
        end
    end

    def destroy
        @article = Article.find(params[:id])
        #宣告變數 從article model去搜尋所對應網頁的參數ID
        @article.destroy
        #刪除文章
        redirect_to root_path
        #轉到首頁
    end


    private

    def article_params
        params.require(:article).permit(:title, :content)
        #定義一個方法 接收來自article  只允許存取title,content
    end




end
