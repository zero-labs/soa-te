class SoundsController < ApplicationController
  before_filter :login_required, :only => [:edit, :update, :destroy]
  
  # GET /sounds
  # GET /sounds.xml
  def index
    @sounds = Sound.find(:all)

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @sounds.to_xml }
    end
  end

  # GET /sounds/1
  # GET /sounds/1.xml
  def show
    redirect_to :action => 'index'
    #@sound = Sound.find(params[:id])
    
    #respond_to do |format|
    #  format.html # show.rhtml
    #  format.xml  { render :xml => @sound.to_xml }
    #end
  end

  # GET /sounds/new
  def new
    @sound = Sound.new
    @body_id = :new_sound
  end

  # GET /sounds/1;edit
  def edit
    @sound = Sound.find(params[:id])
  end

  # POST /sounds
  # POST /sounds.xml
  def create
    # anti-spam check
    unless params[:sound_keep_out].blank? then
      redirect_to sounds_url
      return
    end
    
    @sound = Sound.new(params[:sound])
    respond_to do |format|
      if @sound.save
        flash[:notice] = 'A gravação foi registada com sucesso.'
        format.html { redirect_to sounds_url }
        format.xml  { head :created, :location => sounds_url(@sound) }
      else
        format.html { @body_id = :new_sound; render :action => "new" }
        format.xml  { render :xml => @sound.errors.to_xml }
      end
    end
  end

  # PUT /sounds/1
  # PUT /sounds/1.xml
  def update
    @sound = Sound.find(params[:id])

    respond_to do |format|
      if @sound.update_attributes(params[:sound])
        flash[:notice] = 'A gravação foi actualizada com sucesso.'
        format.html { redirect_to sound_url(@sound) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @sound.errors.to_xml }
      end
    end
  end

  # DELETE /sounds/1
  # DELETE /sounds/1.xml
  def destroy
    @sound = Sound.find(params[:id])
    @sound.destroy

    respond_to do |format|
      flash[:notice] = 'A gravação foi removida.'
      format.html { redirect_to sounds_url }
      format.xml  { head :ok }
    end
  end
  
  def list
    @sounds = Sound.find :all
    respond_to do |format|
      format.html { render :action => 'list' }
    end
  end
  
  def day
    @body_id = :day
    respond_to do |format|
      format.html { render :action => 'day' }
      format.xspf { render :xml => Sound.day_playlist }
    end    
  end
  
  private 
  
  def body_id
    @body_id = :sound 
  end  

end
