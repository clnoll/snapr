require 'spec_helper'

describe Snapr::RateProfile do
  let(:orm) { Snapr::ORM.new }

  it "rates a profile with a like or dislike" do
    # Set up our data
    task = orm.create_user('alex', 'alex')
    emp = orm.create_employee('Bob')

    result = subject.run({ :task_id => task.id, :employee_id => emp.id })
    expect(result.success?).to eq(true)
    expect(result.task.employee_id).to eq(emp.id)
  end

  it "errors if the task does not exist" do
    # Set up our data
    emp = orm.create_employee('Bob')

    result = subject.run({ :task_id => 999, :employee_id => emp.id })
    expect(result.error?).to eq(true)
    expect(result.error).to eq :task_does_not_exist
  end
end
