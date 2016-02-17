class PeopleController < ApplicationController
before_action :set_person, only: [:reinitgrpid, :updtgrpid, :updatesensei]
  # GET /people
  # GET /people.json
  def index
    @people = Person.all
  end

  def reinitialize
    classe = Person.all
    classe.each do |person|
      person.group_id = nil
      person.save
    end
    redirect_to :root
  end

  def reinitgrpid
    @person.group_id = nil
    @person.save
    redirect_to :root
  end

  def updtgrpid
    
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

  def update
    @person.update_attributes(params[:user])
    respond_with @person
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_person
      @person = Person.find(params[:id])
    end


    # Never trust parameters from the scary internet, only allow the white list through.
    def person_params
      params.require(:person).permit(:name, :email, :tel, :group_id, :sensei, :id)
    end
end
