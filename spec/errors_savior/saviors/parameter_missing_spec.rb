describe ErrorsSavior::Saviors::ParameterMissing do
  let(:error_class_name) { 'ActionController::ParameterMissing' }

  it_behaves_like 'a savior'
end
