class ProjectsController < ApplicationController
    load_and_authorize_resource
    before_action :set_project,only: %i[ show edit update destroy users]

    def index
        @project=Project.new
        if current_user
            @projects=current_user.projects if user_signed_in?
        else
            redirect_to :new_user_session
        end
    end

    def show
    end

    def new
        @project=Project.new
       
    end
    # GET /projects/1/edit
    def edit
    end

    def create
        @project=current_user.projects.create(project_params)
        respond_to do |format|      
            if @project.save
                format.html { redirect_to @project, notice: "project was successfully created." }
                format.json { render :show, status: :created, location: @project }
            else
                format.html { render :new, status: :unprocessable_entity }
                format.json { render json: @project.errors, status: :unprocessable_entity }
            end
        end        
    end
    def update
        respond_to do |format|
            if @project.update(project_params)
              format.html { redirect_to @project, notice: "Project was successfully updated." }                  
              format.json { render :show, status: :ok, location: @project }
            else
              format.html { render :edit, status: :unprocessable_entity }                  
              format.json { render json: @project.errors, status: :unprocessable_entity }
            end
        end
    end

    #DELETE projects/1
    def destroy    
        @project.destroy
        respond_to do |format|
            format.html { redirect_to projects_url, notice: "Project was successfully destroyed." }
            format.json { head :no_content }
        end    
    end

    def users
        @users=@project.users
    end
    def new_user
        @all_project_users= UserProject.where(project_id: params[:id]).pluck(:user_id)
        @users=User.where.not(user_type: 'manager').where.not(id:@all_project_users)
    end
    def assign_user
        @assign_new_user=UserProject.create(user_id:params[:user],project_id:params[:id])
        respond_to do |format|       
            if @assign_new_user.save
                format.html { redirect_to users_project_path, notice: "assign_new_user was successfully created." }
                format.json { render :show, status: :created, location: users_project_path }
            else
                format.html { render :new, status: :unprocessable_entity }
                format.json { render json: @assign_new_user.errors, status: :unprocessable_entity }
            end
        end
    end

    private
        def set_project
            @project=Project.find(params[:id])
        end

        def project_params
            params.require(:project).permit(:title,:description)
        end
end
