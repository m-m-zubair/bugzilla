class BugsController < ApplicationController

    before_action :set_bug, only: %i[ show edit update destroy assign_user ]

    def index
        @project=Project.find(params[:project_id])
        @bugs=@project.bugs
    end

    def show
    end

    def new
        @bug = Bug.new
        @project = Project.find(params[:project_id])
        
    end

    def edit
        @project = Project.find(params[:project_id])
        
    end

    def create
        
            
                @bug=Bug.create(bugs_params.merge!(creator_user_id: current_user.id,project_id:params[:project_id]))
                respond_to do |format|
                    if @bug.save
                        format.html { redirect_to project_bugs_path, notice: "Bug was successfully created." }
                        format.json { render :show, status: :created, location: @bug }
                    else
                        format.html { redirect_to new_project_bug_path , notice: @bug.errors.full_messages }
                        format.json { render json: @bug.errors, status: :unprocessable_entity }
                    end
                end  
                  
    end
    
    def update
        @project = Project.find(params[:project_id])
        if current_user.user_type.eql?"manager"
            respond_to do |format|
                if @bug.update(bugs_params)
                  format.html { redirect_to project_bug_path(@project,@bug), notice: "Bug was successfully updated." }
                  format.json { render :show, status: :ok, location: @bug }
                else
                  format.html { render :edit, status: :unprocessable_entity }
                  format.json { render json: @bug.errors, status: :unprocessable_entity }
                end
              end
        else
            format.html { redirect_to edit_project_bugs_path(@project,@bug), notice: "only Manager can Edit the project" }
        end
    end

    def destroy
            @bug.destroy
            respond_to do |format|
                format.html { redirect_to project_bugs_url, notice: "Bug was successfully destroyed." }
                format.json { head :no_content }
            end
    end
    def new_user
        
        
        @bug=Bug.where(id:params[:id]).first
        
        if @bug.developer_user_id?
            @users=User.where(user_type:"developer").where.not(id:@bug.developer_user_id ).where.not(id:@bug.creator_user_id)
        else
            @users=User.where(user_type:"developer").where.not(id:@bug.creator_user_id)
        end
        
        
        
    end

    def assign_user
        
        @project = Project.find(params[:project_id])
        @assign_new_user=@bug.update(developer_user_id: params[:user])
        
        respond_to do |format|      
            if @assign_new_user
                format.html { redirect_to project_bugs_path(@project), notice: "User Assigned  successfully !." }
                format.json { render :show, status: :created, location: project_bugs_path(@project) }
            else
                format.html { render :new, status: :unprocessable_entity }
                format.json { render json: @assign_new_user.errors, status: :unprocessable_entity }
            end
        end
    end

    private

        def set_bug
            @bug=Bug.find(params[:id])
        end
        
        def bugs_params
            params.require(:bug).permit(:title, :description, :deadline, :bug_type, :status, :image)
        end
end
