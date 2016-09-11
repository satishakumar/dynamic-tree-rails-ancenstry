class NodesController < ApplicationController
  before_action :set_node, only: [:show, :edit, :update, :destroy]

  # GET /nodes
  # GET /nodes.json
  def index
    @nodes = Node.where("ancestry is null")
  end

  # POST /nodes
  # POST /nodes.json
  def create
    if(node_params[:parent_id])
      parent = Node.find(node_params[:parent_id])
      @node = Node.create!(:name => node_params[:name], :parent => parent)
    else
      @node = Node.new(node_params)
    end
    respond_to do |format|
      if @node.save
        format.html { redirect_to @node, notice: 'Node was successfully created.' }
        format.json { render :json => {:node_id => @node.id} }
      else
        format.html { render :new }
        format.json { render :json => {:errors => @node.errors} }
      end
    end
  end

  # PATCH/PUT /nodes/1
  # PATCH/PUT /nodes/1.json
  def update
    respond_to do |format|
      if @node.update(node_params)
        format.html { redirect_to @node, notice: 'Node was successfully updated.' }
        format.json { render :json => {:node_id => @node.id} }
      else
        format.html { render :edit }
        format.json { render :json => {:errors => @node.errors} }
      end
    end
  end

  # DELETE /nodes/1
  # DELETE /nodes/1.json
  def destroy
    @node.destroy
    respond_to do |format|
      format.html { redirect_to nodes_url, notice: 'Node was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_node
      @node = Node.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def node_params
      params.require(:node).permit(:name,:parent_id, :id)
      # params.require(:node,:parent_id).permit(:name)
    end
end