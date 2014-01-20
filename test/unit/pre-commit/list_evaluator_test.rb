require 'minitest_helper'
require 'pre-commit/list_evaluator'
require 'plugins/pre_commit/configuration/providers/default'
require 'plugins/pre_commit/configuration/providers/git'
require 'plugins/pre_commit/checks/before_all'
require 'plugins/pre_commit/checks/console_log'

describe PreCommit::ListEvaluator do
  let :configuration do
    PreCommit::Configuration.new(
      PreCommit.pluginator,
      PreCommit::Configuration::Providers.new(nil, [
        PreCommit::Configuration::Providers::Default.new({}),
      ])
    )
  end

  subject do
    PreCommit::ListEvaluator.new(configuration)
  end

  it :list do
    subject.list.gsub(/\s+\n/,"\n").must_equal(<<-EXPECTED)
Available providers: default(0)
Available checks   : before_all ci closure coffeelint common console_log csslint debugger gemfile_path jshint jslint local merge_conflict migration nb_space php pry rails rspec_focus rubocop ruby ruby_symbol_hashrockets tabs whitespace
Default   checks   :
Enabled   checks   :
Evaluated checks   :
Default   warnings :
Enabled   warnings :
Evaluated warnings :
EXPECTED
  end
end
