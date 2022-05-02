# encoding: utf-8
require 'spec_helper'
require 'i18n'

# Use add_testimonial when testing the online interface

module Refinery
  module Admin
    describe 'Testimonials' do
      refinery_login

      context 'Refinery Admin interface' do
        it 'has a Testimonials Tab' do
          visit refinery.testimonials_admin_testimonials_path
          expect(page).to have_content(::I18n.t('title', scope: 'refinery.plugins.refinery_testimonials'))
          expect(page).to have_selector('#plugin_refinery_testimonials')
        end
      end

      context 'When there are no testimonials' do
        it 'Says no items yet' do
          visit refinery.testimonials_admin_testimonials_path
          expect(page).to have_content(::I18n.t('no_items_yet', scope: 'refinery.testimonials.admin.testimonials.records'))
        end

        it "doesn't show reorder testimonials link" do
          visit refinery.testimonials_admin_testimonials_path

          within '#actions' do
            expect(page).to have_no_content(::I18n.t('reorder', scope: 'refinery.testimonials.admin.testimonials.actions'))
            expect(page).to have_no_selector("a[href='/refinery/testimonials']")
          end
        end
      end

      describe 'action links' do
        it 'shows add new testimonial link' do
          visit refinery.testimonials_admin_testimonials_path

          within '#actions' do
            expect(page).to have_content(::I18n.t('create_new', scope: 'refinery.testimonials.admin.testimonials.actions'))
            expect(page).to have_selector("a[href='/refinery/testimonials/new']")
          end
        end

        context 'when some testimonials exist' do
          before { 2.times { |i| FactoryBot.create(:testimonial) } }

          it 'shows reorder testimonials link' do
            visit refinery.testimonials_admin_testimonials_path
            expect(page).to have_content(::I18n.t('reorder_testimonials', scope: 'refinery.testimonials.admin.testimonials.actions'))
            expect(page).to have_selector("a[href='/refinery/testimonials']")
          end
        end
      end

      describe 'new/create', js: true do
        it 'allows a testimonial to be created' do
          visit refinery.testimonials_admin_testimonials_path
          add_testimonial('My first Testimonial', 'Quote')

          expect(page).to have_content("'Quote by My first Testimonial' was successfully added.")

          expect(page.html).to include('Remove this testimonial forever')
          expect(page.html).to include('Edit this testimonial')
          expect(page.html).to include('/refinery/testimonials/1/edit')

          expect(Refinery::Testimonials::Testimonial.count).to eq(1)
        end
      end

      describe 'edit/update' do
        before do
          add_testimonial('Update me', 'quote')

          visit refinery.testimonials_admin_testimonials_path
          expect(page).to have_content('Update me')
        end

        context 'when saving and returning to index' do
          it 'updates testimonial' do
            click_link 'Edit this testimonial', match: :first

            fill_in 'Name', with: 'Updated'
            click_button 'Save'

            expect(page).to have_content("'Quote by Updated' was successfully updated.")
          end
        end
      end

      describe 'Destroy' do
        context 'When a testimonial can be deleted' do
          before do
            FactoryBot.create(:testimonial, name: 'Delete me', quote: 'Quote me')
          end

          it 'Will show delete button' do
            visit refinery.testimonials_admin_testimonials_path
            within '.record' do
              expect(page.html).to include(::I18n.t('delete', scope: 'refinery.testimonials.admin.testimonials.testimonial'))
              expect(page).to have_selector("a[href='/refinery/testimonials/1']")
            end
          end

          it 'Will delete the testimonial' do
            visit refinery.testimonials_admin_testimonials_path
            click_link 'Remove this testimonial forever'

            expect(page).to have_content("'Quote by Delete me' was successfully removed.")
            expect(Refinery::Testimonials::Testimonial.count).to eq(0)
          end
        end
      end

      describe 'Page Controls' do
        let(:page_for_testimonials) {
          page = Refinery::Page.create title: "Add Testimonials to me"
          # we need page parts so that there's a visual editor
          Refinery::Pages.default_parts.each_with_index do |default_page_part, index|
            page.parts.create(title: default_page_part, slug: default_page_part, body: nil, position: index)
          end
          page
        }

        before(:each) do
          visit refinery.admin_edit_page_path(page_for_testimonials)
        end

        it 'Has a testimonials tab' do
          within '#custom_testimonials_tab' do
            expect(page).to have_content('Testimonials')
          end
        end

        context 'when there are no testimonials' do
          it 'informs the user' do
            within '#page_testimonial_selector' do
              expect(page).to have_content('No Testimonials available')
            end
          end
        end

        context 'when testimonials have been created' do
          before { 2.times { |i| FactoryBot.create(:testimonial) } }

          it 'contains a select element' do
            visit refinery.admin_edit_page_path(page_for_testimonials)
            within('#page_testimonial_selector') do
              expect(page).to have_select('testimonial_multiselect')
            end
          end

        end
      end
    end
  end
end
