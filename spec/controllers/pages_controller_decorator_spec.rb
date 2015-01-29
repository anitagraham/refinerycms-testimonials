require "spec_helper"

def set_controls(page, settings)
  defaults ||= {
      testimonials_show: false,
      testimonials_count: 0,
      testimonials_select: 'Recent'
  }
  settings = defaults.merge(settings)
  page.testimonials_show = settings[:testimonials_show]
  page.testimonials_count = settings[:testimonials_count]
  page.testimonials_select = settings[:testimonials_select]
  page.save
end

module Refinery

  describe PagesController, type: :controller do
    refinery_login_with :refinery_user

    after :all do
      Refinery::Page.by_title('Test Controls').delete
      Refinery::Testimonials.Testimonial.delete_all
    end

    let!(:test_page) { FactoryGirl.create(:page, title: 'Test Controls') }
    let(:get_test_page) { get :show, path: 'test-controls' }
    FactoryGirl.create_list(:testimonial, 8)

   context 'With default settings' do

      it 'should not get any testimonials' do
        get_test_page
        expect(test_page.testimonials).to be_nil
      end
    end

    context 'Show testimonials' do
      let(:settings) { {
          testimonials_show: true,
          testimonials_count: 0,
          testimonials_select: 'Recent'}
      }

      context 'when testimonials_count=0' do
        it 'should return all testimonials' do
          set_controls(test_page, settings)
          get_test_page
          expect(test_page.testimonials.size).to eq(8)
        end
      end

      context 'when testimonials_count=4' do
        it 'should return four testimonials' do
          settings[:testimonials_count] = 4
          set_controls(test_page, settings)
          get_test_page
          expect(test_page.testimonials.size).to eq 4
        end
      end

      describe "Change the order of testimonials returned"
      context 'Show testimonials in recent order' do

        it 'should return testimonials with most recent first' do
          set_controls(test_page, settings)
          get :show, path: 'test_controls'
          expect(test_page.testimonials).to be_ordered_by('received_date_desc')
        end
      end

      context 'Show testimonials in random order' do
        it 'should return testimonials in random order' do
          settings[:testimonials_select]='Random'
          set_controls(test_page, settings)
          get :show, path: 'test_controls'
          expect(test_page.testimonials).not_to be_ordered_by('received_date_desc')
        end
      end
    end
  end
end
