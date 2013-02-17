shared_examples "render_template" do
  it "renders the template" do
    action
    response.should render_template template
  end
end

shared_examples "redirect_to" do
  it "redirects to the path" do
    action
    response.should redirect_to path
  end
end