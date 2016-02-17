class PeopleController < ApplicationController
before_action :set_person, only: [:update, :reinitgrpid, :updtgrpid, :updatesensei, :edit, :show]
before_action :set_group, only: [:cleargrp]
  # GET /people
  # GET /people.json
  def index
    @people = Person.all
  end


  # GET /people/1
  # GET /people/1.json
  def show
  end

  # GET /people/new
  def new
    @person = Person.new
  end

  # GET /people/1/edit
  def edit
  end



  # POST /people
  # POST /people.json
  def create
    @person = Person.new(person_params)

    respond_to do |format|
      if @person.save
        format.html { redirect_to root_path, notice: 'Person was successfully created.' }
        format.json { render :show, status: :created, location: @person }
      else
        format.html { render :new }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /people/1
  # PATCH/PUT /people/1.json
  def update
    respond_to do |format|
      if @person.update_attributes(person_params)
        format.html { redirect_to(@person, :notice => 'Poeple was successfully updated.') }
        format.json { respond_with_bip(@person) }
      else
        format.html { render :action => "edit" }
        format.json { respond_with_bip(@person) }
      end
    end
  end

  def reinitialize
    classe = Person.all
    classe.each do |person|
      person.group_id = nil
      person.sensei = false
      person.save
    end
    redirect_to :root
  end

  def cleargrp
    classe = Person.all
    classe.each do |person|
      if person.group_id == @group.id
      person.group_id = nil
      person.sensei = false
      person.save
    end
    end
    redirect_to :root
  end


  def reinitgrpid
    @person.group_id = nil
    @person.sensei = false
    @person.save
    redirect_to :root
  end



  def updatesensei
    check= @person.sensei
    if check
      @person.sensei = false
    else
      @person.sensei = true
    end
    @person.save
    redirect_to :root
  end




  private
    # Use callbacks to share common setup or constraints between actions.
    def set_person
      @person = Person.find(params[:id])
    end
    def set_group
      @group = Group.find(params[:id])
    end


    # Never trust parameters from the scary internet, only allow the white list through.
    def person_params
      params.require(:person).permit(:name, :email, :tel, :group_id, :sensei, :id)
    end
end
