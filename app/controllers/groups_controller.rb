class GroupsController < ApplicationController

  before_action :set_group, only: [:show, :edit, :update, :destroy]
  before_action :set_group_nbr, only: [:go_randomize]

  # GET /groups
  # GET /groups.json
  def index
    @groups = Group.all
    @people = Person.all
  end

  def go_randomize
    @groups = Group.all
    @people = Person.all
    max_by_group = (@people.size/ @groups.size).ceil+1

    id_group = []
    @people.each do |person|
      person.group_id = nil
      person.save
    end

    @groups.each do |group|
        id_group << group.id
    end

    @people.each do |person|
      rand_grp = id_group.sample
      person.group_id = rand_grp
      person.save

      if Person.where(group_id:rand_grp).size == max_by_group
          id_group.delete(rand_grp)
      end
    end
    redirect_to root_path, notice: "#{max_by_group}"

  end
  # GET /groups/1
  # GET /groups/1.json
  def show
  end

  # GET /groups/new
  def new
    @group = Group.new
  end

  # GET /groups/1/edit
  def edit
  end

  # POST /groups
  # POST /groups.json
  def create
    @group = Group.new(group_params)

    respond_to do |format|
      if @group.save
        format.html { redirect_to root_path, notice: 'Group was successfully created.' }
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end




  # PATCH/PUT /groups/1
  # PATCH/PUT /groups/1.json
  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to root_path, notice: 'Group was successfully updated.' }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    @group.destroy
    respond_to do |format|
      format.html { redirect_to groups_url, notice: 'Group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.find(params[:id])
    end

    def set_group_nbr
      if Group.all.size < 2
        redirect_to root_path, notice: 'Need at least 2 groupe'
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_params
      params.require(:group).permit(:name, :salle, :tache)
    end
    def person_params
      params.require(:person).permit(:name, :email, :tel, :group_id, :sensei)
    end

end
