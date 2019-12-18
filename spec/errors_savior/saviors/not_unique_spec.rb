describe ErrorsSavior::Saviors::NotUnique do
  let(:error_class_name) { 'ActiveRecord::RecordNotUnique' }

  it_behaves_like 'a savior'
end
