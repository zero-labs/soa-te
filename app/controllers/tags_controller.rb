class TagsController < ApplicationController
  before_filter :login_required, :except => [:index, :show, :auto_complete_for_tag_name, :play_tag]

  # GET /tags
  # GET /tags.xml
  def index
    #@tags = Tag.find(:all)
    @tags = Tag.tags
    @tag = Tag.find(params[:id]) if params.has_key?('id')

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @tags.to_xml }
    end
  end

  # GET /tags/1
  # GET /tags/1.xml
  # GET /tags/1.xspf
  def show
    @tag = Tag.find(params[:id])

    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @tag.to_xml }
      format.xspf { render :xml => @tag.playlist }
    end
  end

  # GET /tags/new
  def new
    @tag = Tag.new
  end

  # GET /tags/1;edit
  def edit
    @tag = Tag.find(params[:id])
  end

  # POST /tags
  # POST /tags.xml
  def create
    @tag = Tag.new(params[:tag])

    respond_to do |format|
      if @tag.save
        flash[:notice] = 'Tag criada com sucesso.'
        format.html { redirect_to tag_url(@tag) }
        format.xml  { head :created, :location => tag_url(@tag) }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @tag.errors.to_xml }
      end
    end
  end

  # PUT /tags/1
  # PUT /tags/1.xml
  def update
    @tag = Tag.find(params[:id])

    respond_to do |format|
      if @tag.update_attributes(params[:tag])
        flash[:notice] = 'Tag foi actualizada.'
        format.html { redirect_to tag_url(@tag) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @tag.errors.to_xml }
      end
    end
  end

  # DELETE /tags/1
  # DELETE /tags/1.xml
  def destroy
    @tag = Tag.find(params[:id])
    @tag.destroy

    respond_to do |format|
      flash[:notice] = 'Tag foi removida.'
      format.html { redirect_to tags_url }
      format.xml  { head :ok }
    end
  end
  
  def auto_complete_for_tag_name
    @items = Tag.find_similar_by_name(params[:sound][:tags].downcase)
    render :inline => "<%= auto_complete_result @items, 'name' %>"
  end

  def play_tag
    @tag = Tag.find(params[:id])
    @playlist = "#{@tag.id}"
    render :partial => 'playlist'
  end

  private

  # Redefine this before_filter
  def body_id
    @body_id = :tags
  end

end
