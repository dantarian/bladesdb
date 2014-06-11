class FoodOptionsController < ApplicationController
  # GET /food_options
  # GET /food_options.xml
  def index
    @food_options = FoodOption.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @food_options }
    end
  end

  # GET /food_options/1
  # GET /food_options/1.xml
  def show
    @food_option = FoodOption.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @food_option }
    end
  end

  # GET /food_options/new
  # GET /food_options/new.xml
  def new
    @food_option = FoodOption.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @food_option }
    end
  end

  # GET /food_options/1/edit
  def edit
    @food_option = FoodOption.find(params[:id])
  end

  # POST /food_options
  # POST /food_options.xml
  def create
    @food_option = FoodOption.new(params[:food_option])

    respond_to do |format|
      if @food_option.save
        flash[:notice] = 'FoodOption was successfully created.'
        format.html { redirect_to(@food_option) }
        format.xml  { render :xml => @food_option, :status => :created, :location => @food_option }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @food_option.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /food_options/1
  # PUT /food_options/1.xml
  def update
    @food_option = FoodOption.find(params[:id])

    respond_to do |format|
      if @food_option.update_attributes(params[:food_option])
        flash[:notice] = 'FoodOption was successfully updated.'
        format.html { redirect_to(@food_option) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @food_option.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /food_options/1
  # DELETE /food_options/1.xml
  def destroy
    @food_option = FoodOption.find(params[:id])
    @food_option.destroy

    respond_to do |format|
      format.html { redirect_to(food_options_url) }
      format.xml  { head :ok }
    end
  end
end
