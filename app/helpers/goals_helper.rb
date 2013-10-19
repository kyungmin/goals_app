module GoalsHelper
  def status(goal)
    goal.completed == true ? "Completed" : "Incomplete"
  end

  def show_selected(goal, option)
    goal.privacy == option ? " selected" : ""
  end

end
