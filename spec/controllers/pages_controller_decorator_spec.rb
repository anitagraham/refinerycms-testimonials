require "spec_helper"

module Refinery

  describe PagesController, type: :controller do
    refinery_login

    let!(:page){ Refinery::Page.create(title: "Test Controls")}

    let(:testimonials) {3.times FactoryBot.create(:testimonial)}

    context 'With default settings' do
      it 'should not get any testimonials' do
        get :show, params: { use_route: 'pages/test-controls' }
        expect(assigns(:testimonials)).to be_nil
      end
    end

    describe 'Change  settings' do
      before(:each) do
        test_page = Refinery::Page.by_title('Test Controls').first
        test_page.testimonials_show = true
        test_page.save
      end

      describe 'testimonials_show set' do
        context 'testimonials_count 0' do
          it 'should return all testimonials' do
            get :show, params: { use_route: 'pages/test-controls' }
            expect(assigns(:testimonials).count).to eq 3
          end
        end

        context 'testimonials_count set' do
          before do
            test_page = Refinery::Page.by_title('Test Controls').first
            test_page.testimonials_count = 4
            test_page.save
          end
          it 'should return two testimonials' do
            get :show, 'test-controls'
            expect(assigns(:testimonials).count).to eq 4
          end
        end

        context 'Show testimonials in recent order' do
          before do
            test_page = Refinery::Page.by_title('Test Controls').first
            test_page.testimonials_select = 'Recent'
            test_page.testimonials_count=8
            test_page.save
          end
          it 'should return testimonials with most recent first' do
            get :show, path: 'test-controls'
            expect(assigns(:testimonials)).to be_ordered_by('received_date_desc')
          end
        end

        context 'Show testimonials in random order' do
          before do
            test_page = Refinery::Page.by_title('Test Controls').first
            test_page.testimonials_select = 'Random'
            test_page.testimonials_count=8
            test_page.save
          end
          it 'should return testimonials in random order' do
            get :show, path: 'test-controls'
            expect(assigns(:testimonials)).not_to be_ordered_by('received_date_desc')
          end
        end

      end
    end
  end
end
