# TDD
# Lets you write only the code that is necessary to pass your tests. No excess code
# Tests can help to convey the functionality and intent of your application.

# RSpec
# describe :: can reference strings or classes themself
# they are basic building blocks to organize your tests into logical, coherent groups to test.

describe User do
  ...
end

describe Guest do
  ...
end

describe Attacker do
  ...
end

# A good tip is to tighten your scope even more.
# Create multiple :describe: blocks, and focus them around instance (#) or class methods (.) instead
# All you need is to provide the class name with an extra string that references the method to test.

describe Agent, '#favorite_gadget' do
  ...
end

describe Agent, '#favorite_gun' do
  ...
end

describe Agent, '.gamler' do
  ...
end

# Within the :describe: groups, we can use another scope of :it: blocks.

describe Agent, '#favorite_gadget' do

  it 'returns one item, the favorite gadget of the agent ' do
    ...
  end

end

# expect()
# Lets you verify or falsify the part of the system you want to test.
# Expects that you provide it with an object and excercise whatever method under test on it.
# You write the asserted outcome on the right side.
#
# You have the option to go positive (.to eq) or negative (.not_to eq)

describe Agent, '#favorite_gadget' do

  it 'returns one item, the favorite gadget of the agent ' do
    expect(agent.favorite_gadget).to eq 'Walther PPK'
  end

end

# BEST PRACTISES
# Compose tests in four phases:
# 1. Test setup
# 2. Test excercise
# 3. Test verification
# 4. Test teardown

# SETUP
# Prepare the scenario under which the test is supposed to run.
# In most cases, this will include data needed to be ready for some kind of excercise
# Tip: Dont overcomplicate things, and set up only the minimum anount necessary to make this test work.

agent = Agent.create(name: 'James Bond')
mission = Mission.create(name: 'Moonraker', status: 'Briefed')

# EXCERCISE
# Actually runs the thing you want to test in Spec

status = mission.agent_status

# VERIFY
# Verify if your assertion about test is being met or not
# Test the system against your own expectations

expect(status).not_to eq 'MIA')

# TEARDOWN
# Framework takes care of memory and database cleaning issues - a reset, basically
# Get back to pristine state to run new tests without any surprises from the currently running ones

describe Agent, '#favorite_gadget' do

  it 'returns one item, the favorite gadget of the agent ' do
  # SETUP
    agent = Agent.create(name: 'James Bond')
    q = Quarter_master.create(name: 'Q')
    q.technical_briefing(agent)

  # Exercice
    favorite_gadget = agent.favorite_gadget

  # Verify
    expect(favorite_gadget).to eq 'Walther PPK'

  # Teardown is for the mostly handled by RSPEC itself
  end
end


# THE HARD THING ABOUT TESTING
# Confusing to newcomers
# Preseverance is important

# Final Thoughts
# Writing individual tests, make their objects do the simplest thing possible to achieve your goal - highly focused tests are really key
# Design your application via very simple steps and then follow the errors you test suite is providing you
#
# Only implement what is necessary to get the app GREEN. No more, no less!
# That is the "Driven" part in test-driven development.
# Your work is guided by the needs of your tests
