class AttendanceMailer < ApplicationMailer

  default from: 'etrenjeu@gmail.com'
 

  def attendance_email(attendance)

    @attendance = attendance

    @user = @attendance.user

    # c'est cet appel à mail() qui permet d'envoyer l’e-mail en définissant destinataire et sujet.
    mail(to: @attendance.event.administrator.email, subject: "Inscription à l'évènement " + @attendance.event.title) 
  end


end