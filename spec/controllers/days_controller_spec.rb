RSpec.describe DaysController, type: :controller do
#   GET days/index
  context "GET to /days" do
    let(:response) { get "/days" }

    it "returns status 200 OK" do
      expect(response.status).to eq 200
    end
  end

#   GET show
#     assigns the requested widget as @widget
#   GET new
#     assigns a new widget as @widget
#   GET edit
#     assigns the requested widget as @widget
#   POST create
#     with valid params
#       creates a new Widget
#       assigns a newly created widget as @widget
#       redirects to the created widget
#     with invalid params
#       assigns a newly created but unsaved widget as @widget
#       re-renders the 'new' template
#   PUT update
#     with valid params
#       updates the requested widget
#       assigns the requested widget as @widget
#       redirects to the widget
#     with invalid params
#       assigns the widget as @widget
#       re-renders the 'edit' template
#   DELETE destroy
#     destroys the requested widget
#     redirects to the widgets list
end
